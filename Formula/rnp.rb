class Rnp < Formula
  desc "RNP is a set of OpenPGP (RFC4880) tools"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp.git",
      :tag => "v0.13.1",
      :revision => "ad35f7c37467800a1b2b081fd80e1eb307dc2af9"
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
