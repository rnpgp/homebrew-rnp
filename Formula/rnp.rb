# frozen_string_literal: true

class Rnp < Formula
  desc "High performance C++ OpenPGP library used by Mozilla Thunderbird"
  homepage "https://github.com/rnpgp/rnp"
  url "https://github.com/rnpgp/rnp/archive/refs/tags/del_20240828_ap6_bsi.tar.gz"
  sha256 "c1c79477455193c7b4beb8ca0556064d110f2983bb0c2c60d5eafa3a194dd127"
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
