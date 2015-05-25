#-------------------------------------------------------------
# Print (mis)fortune
#-------------------------------------------------------------

if exists fortune; then
  echo -en ${WHITE:2:10}
  if exists cowsay; then
    fortune -a -s | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf | head -n1)
  else
    fortune -a -s
  fi
fi
