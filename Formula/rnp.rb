class Rnp < Formula
  desc "High-performance OpenPGP command-line tools and library"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp/archive/refs/tags/v0.15.1.tar.gz"
  sha256 "dee1b21ea7ba0182356b6ea23124706f62f3f11a65fcf9c62620e78c0ce7d436"
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
