cd $(dirname $0)

ROOT_DIR=`pwd`
PRODUCT_DIR=product
BUILD_DIR=build

# BUILD_TYPE=Release
BUILD_TYPE=Debug

if [ -d "$PRODUCT_DIR" ]; then
    rm -rf "$PRODUCT_DIR"
fi

if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

cmake -B  "$BUILD_DIR" -S . -DCMAKE_BUILD_TYPE=$BUILD_TYPE
if [ $? != 0 ]; then
    exit 0
fi

cmake --build "$BUILD_DIR"
if [ $? != 0 ]; then
    exit 0
fi

cmake --install "$BUILD_DIR" --prefix "$ROOT_DIR/$PRODUCT_DIR"
if [ $? != 0 ]; then
    exit 0
fi
