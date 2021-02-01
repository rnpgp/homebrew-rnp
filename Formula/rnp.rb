class Rnp < Formula
  desc "Set of OpenPGP (RFC4880) tools"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp.git", tag: "v0.14.0", revision: "7c8492b44ab5105dab410cfd00f35b492b68d48e"
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
