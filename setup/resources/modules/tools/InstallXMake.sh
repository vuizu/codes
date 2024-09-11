set -eux
set -o pipefail

export prefix=$1
curl -fsSL https://xmake.io/shget.text | bash

# xmake update --integrate
tail -n3 ~/.profile >> ~/.bashrc && echo -e '\n' >> ~/.bashrc