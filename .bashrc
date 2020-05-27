# bashrc

# load the files in bashrc.d
for FILE_NAME in ~/.config/bashrc.d/*.sh; do
  source $FILE_NAME
done
