# frozen_string_literal: true

class Rnp < Formula
  desc "High-performance OpenPGP command-line tools and library"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp/archive/refs/tags/v0.15.1.tar.gz"
  sha256 "ce14bec9d361f9606a2448096463b8a563692daf0c8a758424b1a0def9d3f787"
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
