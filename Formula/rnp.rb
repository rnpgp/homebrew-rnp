class Rnp < Formula
  desc "RNP is a set of OpenPGP (RFC4880) tools"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp.git",
      :tag => "v0.14.0",
      :revision => "d1b6c731e99d3fd51fa130c87a8c9329a7c25406"
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
