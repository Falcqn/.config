# bashrc

# load the files in bashrc.d
for FILE_NAME in ~/.bashrc.d/*.sh; do
  source $FILE_NAME
done
