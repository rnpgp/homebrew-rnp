class Rnp < Formula
  desc "RNP OpenPGP command-line tools and library"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp.git", tag: "v0.15.1", revision: "1af627eb7d9ade84ae95078d87280ded40a91e1d"
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
