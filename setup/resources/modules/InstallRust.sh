set -eux
set -o pipefail

RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh