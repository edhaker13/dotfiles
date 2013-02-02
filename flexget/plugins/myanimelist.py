import logging
import re
from flexget.entry import Entry
from flexget.plugin import PluginError
from flexget.plugin import register_plugin
from flexget.utils.cached_input import cached
from flexget.utils.soup import get_soup
from flexget.utils.tools import urlopener
from requests import RequestException

log = logging.getLogger('myanimelist')

class MyAnimeList(object):
    """A simple MyAnimeList.net input plugin for FlexGet.
       Creates an entry for each item in the current watching anime list.

    Syntax:

    myanimelist:
      username: <value>

  Example:

      import_series:
        from:
          myanimelist:
            username: 'your username'

    Option username are required. Anime list must be public.
    """

    def validator(self):
        from flexget import validator
        root = validator.factory('dict')
        root.accept('text', key='username', requried=True)
        return root

    @cached('myanimelist', persist='2 hour')
    def on_task_input(self, feed, config):
        url = 'http://myanimelist.net/animelist/%s&status=1&order=0' % (config['username'])

        page = urlopener(url, log)
        soup = get_soup(page)

        if soup.find("div", {"class": "badresult"}):
            raise PluginError('Anime list isn\'t public.')

        pattern = re.compile('^((http?):\/)?\/?(myanimelist.net)+((\/\w+)*\/)([\w\-\.]+[^#?\s]+)?')

        entries = []
        for link in soup.findAll("a", {"class": "animetitle"}):
            if not link.has_key('href'):
                continue

            if not link.contents:
                continue

            match = re.match(pattern, link['href'])

            if not match:
                continue

            title = match.group(6).replace('_',' ')
            entries.append(Entry(title, ''))

        return entries

register_plugin(MyAnimeList, 'myanimelist', api_ver=2)
