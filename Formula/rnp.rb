# frozen_string_literal: true

class Rnp < Formula
  desc "High-performance OpenPGP command-line tools and library"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp/archive/refs/tags/v0.15.2.tar.gz"
  sha256 "198f239808093312d61a54fcdde94aa147260867bde9ee521a31185bab34747e"
  head "https://github.com/rnpgp/rnp.git"

  bottle do
    root_url "https://github.com/rnpgp/homebrew-rnp/releases/download/rnp-0.15.2"
    sha256 cellar: :any, catalina: "13cfb1132fe0c330e2ed2c5d613d27724768d81b68cc6470e65d71babb412278"
  end

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
    testin = testpath/"message.txt"
    testin.write "hello"
    encrypted = testpath/"enc.rnp"
    decrypted = testpath/"dec.rnp"
    shell_output("rnpkeys --generate-key --password=PASSWORD")
    shell_output("rnp -c --password DUMMY --output #{encrypted} #{testin}")
    shell_output("rnp --decrypt --password DUMMY --output #{decrypted} #{encrypted}")
    cmp testin, decrypted
  end
end
