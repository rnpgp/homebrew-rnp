# frozen_string_literal: true

class Rnp < Formula
  desc "High-performance OpenPGP command-line tools and library"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp/archive/refs/tags/v0.16.3.tar.gz"
  sha256 "5c4951e46cc29524a9eae90378414f88e6e0b54b59a1f44c75101b9022835e96"
  license all_of: ["MIT", "BSD-2-Clause", "BSD-3-Clause"]
  head "https://github.com/rnpgp/rnp.git"

  depends_on "cmake" => :build
  depends_on "botan"
  depends_on "json-c"

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DBUILD_TESTING=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    testin = testpath / "message.txt"
    testin.write "hello"
    encr = "#{testpath}/enc.rnp"
    decr = "#{testpath}/dec.rnp"
    shell_output("#{bin}/rnpkeys --generate-key --password=PASSWORD")
    shell_output(
      "#{bin}/rnp -c --password DUMMY --output #{encr} #{testin}",
    )
    shell_output(
      "#{bin}/rnp --decrypt --password DUMMY --output #{decr} #{encr}",
    )
    cmp testin, decr
  end
end
