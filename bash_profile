source ~/.bashrc

for FILE_NAME in ~/.config/bash_profile.d/*.sh; do
  source $FILE_NAME
done
