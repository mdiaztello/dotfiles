
#!/bin/bash

for file in $(ls -d .[^.]*); do
    echo cp -r $file $HOME/$file
done
