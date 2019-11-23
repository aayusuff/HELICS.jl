using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, ["libhelicsSharedLib"], :libhelicsSharedLib),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/GMLC-TDC/HELICSBuilder/releases/download/v2.3.1"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.aarch64-linux-gnu-gcc7.tar.gz", "65f1a79736231d776821b56f74507cf973c68d1d703b3099492d31723c377284"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.aarch64-linux-gnu-gcc8.tar.gz", "6f00dd6f9911b287ca7958cfcf94c531057d5f817055f86844a10e444dc5c2bc"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.aarch64-linux-musl-gcc7.tar.gz", "9d4ffadc1fb5e7d52fff9d856efd2ee3b8ef2ade19279733cdf17e48d4fa0442"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.aarch64-linux-musl-gcc8.tar.gz", "763cb9dc5ee01c5235b0f8f07e3f034e62d10d6da00925190f905c700ae1c070"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.arm-linux-gnueabihf-gcc7.tar.gz", "1a8b3290e901c5cbe752ecef56f89d9fb405d853aa661866ec4e40279cb9ca83"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.arm-linux-gnueabihf-gcc8.tar.gz", "20755c83ff824e790b8952a013ec706954d7bd4ebc76f0059aa17ecbfd6992a0"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.arm-linux-musleabihf-gcc7.tar.gz", "0e03b5dd150f54192751b24434725d1caaf2f2cf3b74e675da2a00390d7b607a"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.arm-linux-musleabihf-gcc8.tar.gz", "c0f14edb91307c8d8d5a7e6355b41abd67d136429d4916a3cab9fd82000be3e9"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.i686-linux-gnu-gcc7.tar.gz", "4e7f600d292a4bea2c69f7735ea68dc48735d433abc1a4bacd55019244450f7d"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.i686-linux-gnu-gcc8.tar.gz", "cedb161068daca01326f8c8b884e3828a948e4b54e7e8348e89f2ab8af571948"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.i686-linux-musl-gcc7.tar.gz", "8773fb810a8f7f06e7fae8ac4157f0b28f587ba1135b816905e8a708d02075cf"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.i686-linux-musl-gcc8.tar.gz", "06e55e619095b22c8a2079481cf4330e42fb90c2d431b20eb8301524979b09ae"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.powerpc64le-linux-gnu-gcc7.tar.gz", "07c22f14b9184a01edd07b08f84a34613e5497415d3061189317caa695907517"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.powerpc64le-linux-gnu-gcc8.tar.gz", "4c22c296e2cc1d24f410f6cfa15e353cd8dd6dda0dbf78910c93865135cbcbe8"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-apple-darwin14-gcc7.tar.gz", "b71cae8fe83b4f48924ac519ff656e678e0c2337c1e63ee2de1db85c019fd8b0"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-apple-darwin14-gcc8.tar.gz", "aa00bc828366e9a7d9e14e478434d3b54f77c41bbe63a4d4e44d823e83f38d4d"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-linux-gnu-gcc7.tar.gz", "f1eb4f7ee4a0bb74a09c0ce106def0948fb3904c2b770425b5b5b9833a8323b7"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-linux-gnu-gcc8.tar.gz", "1fab1220e986409a1e9f5af017e98a677a3819b1b7aaf8f8e4f765b535c685a7"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-linux-musl-gcc7.tar.gz", "53e66cd4549f0c559dad566665c7a08c6c413672c5db7ad953e0a827b777faa7"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-linux-musl-gcc8.tar.gz", "e358347be46d8e95026f7c5d0c281719a16b5f2c7621f5d6247a2c119f9ad6e4"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-w64-mingw32-gcc7.tar.gz", "ff7ff107ad93f6f8ecc8cbd5f5e688abfaba82d65b31c6dd18f6d1843c79ae9c"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/libhelicsSharedLib.v2.3.1.x86_64-w64-mingw32-gcc8.tar.gz", "1846a1f868c033966708dbd6c3d22bc78d91af9a952d7e629ddd661cf186a210"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
dl_info = choose_download(download_info, platform_key_abi())
if dl_info === nothing && unsatisfied
    # If we don't have a compatible .tar.gz to download, complain.
    # Alternatively, you could attempt to install from a separate provider,
    # build from source or something even more ambitious here.
    error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")
end

# If we have a download, and we are unsatisfied (or the version we're
# trying to install is not itself installed) then load it up!
if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
    # Download and install binaries
    install(dl_info...; prefix=prefix, force=true, verbose=verbose)
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)