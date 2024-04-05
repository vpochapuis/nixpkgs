{ lib, rustPlatform, fetchFromGitHub, pkg-config, udev, stdenv }:

# For more information on using `buildRustPackage` please take a look at:
# https://nixos.org/manual/nixpkgs/stable/#compiling-rust-applications-with-cargo
rustPlatform.buildRustPackage rec {
  pname = "ldproxy";
  version = "0.31.4";

  # The source of this tools actually comes from the set of tools located in the `esp-rs:embuild` repository
  # cf: https://github.com/esp-rs/embuild
  src = fetchFromGitHub {
    owner = "esp-rs";
    repo = "embuild";
    rev = "${pname}-v${version}";
    sha256 = "sha256-CPMcFzfP/l1g04sBLWj2pY76F94mNsr1RGom1sfY23I=";
  };

  # However we are only interested in building the specific crate located at `/ldproxy`
  # cf: https://github.com/esp-rs/embuild/tree/v0.31.4/ldproxy
  buildAndTestSubdir = "ldproxy";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    udev
  ];

  cargoSha256 = "sha256-dpdd4Yr92DrKeKrXx/OBkUQVo+bCNr+9VwXI7tvLAaU=";

  meta = with lib; {
    description = "Linker Proxy: a simple tool to forward linker arguments to the actual linker executable";
    homepage = "https://github.com/esp-rs/embuild/tree/v0.31.4/ldproxy";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ vpochapuis ];
  };
}
