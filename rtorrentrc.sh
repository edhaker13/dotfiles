# Torrent sessions, to save and resume
session = /srv/incoming

# Default directory to save the downloaded torrents.
directory = /srv/incoming/

# Network settings
peer_exchange = yes
dht = auto

# Watch a directory for new torrents and set the download target path
schedule = watch_directory_1,10,10,"load_start=/srv/torrents/*.torrent,d.set_custom1=/srv/downloads,d.set_custom2=1,view.set_visible=downloads"
schedule = watch_directoy_anime,5,10,"load_start=/srv/torrents/anime/*.torrent,d.set_custom3=/srv/anime,view.set_visible=anime"
schedule = watch_directory_tv,10,10,"load_start=/srv/torrents/tv/*.torrent,d.set_custom4=/srv/tv,view.set_visible=tv"
# Restart torrents that have been copied back
schedule = tied_directory,10,10,start_tied=
# Stop torrents which have been deleted from watch directory
schedule = untied_directory,10,10,stop_untied=

# Close torrents when diskspace is low.
schedule = low_diskspace,5,60,close_low_diskspace=1G

# Stop torrents when reaching upload ratio in percent,
# when also reaching total upload in bytes, or when
# reaching final upload ratio in percent.
# example: stop at ratio 1.0 with at least 200 MB uploaded, or else ratio 20.0

#ratio usage with rtorrent above 0.8.4
# Enable the default ratio group.
ratio.enable=
# Change the limits, the defaults should be sufficient.
ratio.min.set=100
ratio.max.set=2000
ratio.upload.set=200M
# Changing the command triggered when the ratio is reached.
system.method.set = group.seeding.ratio.command, d.close=, d.erase=

# Move finished downloads to downloaded - for rtorrent above 0.8.6/12.6
system.method.set_key = event.download.finished,move_complete,"d.set_directory=$d.get_custom1=;execute=mv,-u,$d.get_base_path=,$d.get_custom1="
system.method.set_key = event.download.finished,set_done_var,d.set_custom2=

# remove incomplete downloads from disk that have been deleted from rTorrent - for rtorrent above 0.8.6/12.6
system.method.set_key = event.download.erased,rm_incomplete,"branch=d.get_custom2=,\"execute={rm,-rf,--,$d.get_base_path=}\""

# rutorrent configuration
execute_nothrow={rm,/srv/incoming/rtorrent.sock}
scgi_local = /srv/incoming/rtorrent.sock
# execute = {chgrp,www-data,/srv/incoming/rtorrent.sock}
execute = {chmod,og=rwx,/srv/incoming/rtorrent.sock}
#execute = {php,/var/www/rutorrent/initplugins.php, edhaker13,&}

# labels configuration
# UI/VIEW: Label views, rotate through views using the "L" key
method.insert = view.label.add, simple, "view.add=\"$cat=label_,$argument.0=\" ;view.persistent=\"$cat=label_,$argument.0=\""
method.insert = view.label.next, simple, "execute.nothrow.bg=~/bin/rt-nextlabel,~/.rtorrent.rc,$ui.current_view="
# branch=pyro.extended=,"schedule = bind_nextlabel,0,0,\"ui.bind_key=download_list,L,view.label.next=\""
# Set the labels
view.label.add = downloads
view.label.add = anime
view.label.add = tv

