set -eux
set -o pipefail

# python3.9 - 3.11
curl -s https://get.modular.com | sh -s -- 7939aa45-b889-47ef-8551-093f75dd2470 && \
    modular install --install-version 24.4.0 max && \
    # numpy==1.24.4
    MAX_PATH=$(modular config max.path) && \
    python3 -m pip install --find-links $MAX_PATH/wheels max-engine && \
    BASHRC=$(echo "$HOME/.bashrc") && \
    echo -e '\nexport MODULAR_HOME="'$HOME'/.modular"' >> "$BASHRC" && \
    echo 'export PATH="'$MAX_PATH'/bin:$PATH"' >> "$BASHRC"