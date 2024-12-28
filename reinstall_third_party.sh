cd $(dirname "$0")

ROOT_DIR=`pwd`
CURRENT_SYSTEM_NAME=`uname -s`
CURRENT_SYSTEM_ARCH=`uname -m`

TEMP_DIR=temp
PREFIX_DIR=prefix/$CURRENT_SYSTEM_NAME-$CURRENT_SYSTEM_ARCH
THIRD_PARTY_DIR=third_party

if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi
mkdir -p "$TEMP_DIR"

if [ -d "$PREFIX_DIR" ]; then
    rm -rf "$PREFIX_DIR"
fi
mkdir -p "$PREFIX_DIR"

# 安装 OpenSSL
if [ -f "$THIRD_PARTY_DIR/openssl-3.4.0.tar.gz" ]; then
    build_types=("debug" "release")
    for BUILD_TYPE in "${build_types[@]}"; do
        cd "$ROOT_DIR/$TEMP_DIR"
        tar -xzf "$ROOT_DIR/$THIRD_PARTY_DIR/openssl-3.4.0.tar.gz"
        cd openssl-3.4.0
        ./configure --prefix="$ROOT_DIR/$PREFIX_DIR/$BUILD_TYPE" --$BUILD_TYPE no-shared no-docs no-dso
        make
        # make test
        make install
        cd ..
        rm -rf openssl-3.4.0
    done
    cd "$ROOT_DIR"
fi

# 安装 Boost
if [ -f "$THIRD_PARTY_DIR/boost-1.86.0-b2-nodocs.tar.gz" ]; then
    build_types=("debug" "release")
    for BUILD_TYPE in "${build_types[@]}"; do
        cd "$ROOT_DIR/$TEMP_DIR"
        tar -xzf "$ROOT_DIR/$THIRD_PARTY_DIR/boost-1.86.0-b2-nodocs.tar.gz"
        cd boost-1.86.0
        ./bootstrap.sh --with-libraries=all
        ./b2 --prefix="$ROOT_DIR/$PREFIX_DIR/$BUILD_TYPE"  variant=$BUILD_TYPE link=static install
        cd ..
        rm -rf boost-1.86.0
    done
    cd "$ROOT_DIR"
fi

if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi
