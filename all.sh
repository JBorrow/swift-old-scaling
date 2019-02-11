#!/bin/bash

bash grab_and_untar.sh
bash compile_and_move.sh
bash grab_ics.sh
wait
bash make_batch.sh
bash submit_batch.sh
bash cleanup_files.sh
