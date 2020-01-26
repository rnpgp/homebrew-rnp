class Rnp < Formula
  desc "RNP is a set of OpenPGP (RFC4880) tools"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp.git",
      :tag => "v0.13.1",
      :revision => "0055907d3f3dd845f3283195b5d8924260aebbc4"
  head "https://github.com/rnpgp/rnp.git"

  depends_on "cmake" => :build
  depends_on "botan"
  depends_on "json-c"

  def install
    mkdir "build" do
      system(
        "cmake",
        "..",
        *std_cmake_args,
      )
      system "make", "install"
    end
  end

  test do
    system "rnp", "--version"
  end
end
