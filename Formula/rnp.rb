# frozen_string_literal: true

class Rnp < Formula
  desc "High performance C++ OpenPGP library used by Mozilla Thunderbird"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp/releases/download/v0.17.1/rnp-v0.17.1.tar.gz"
  sha256 "3095e2439ecb7b65f0ab72b7bbfafeb39bb1dda3c24c2ae110719a41bbfbf37d"
  license all_of: ["MIT", "BSD-2-Clause", "BSD-3-Clause"]
  head "https://github.com/rnpgp/rnp.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "botan"
  depends_on "json-c"
  uses_from_macos "bzip2"
  uses_from_macos "zlib"

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
