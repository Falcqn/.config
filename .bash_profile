source ~/.bashrc

for FILE_NAME in ~/.bash_profile.d/*.sh; do
  source $FILE_NAME
done
