class Rnp < Formula
  desc "OpenPGP (RFC 4880) tools, replacement of GnuPG"
  homepage "https://github.com/riboseinc/rnp"
  # url "https://github.com/riboseinc/rnp/archive/3.99.18.tar.gz"
  # sha256 "b61ae76934d4d125660530bf700478b8e4b1bb40e75a4d60efdb549ec864c506"
  head "https://github.com/riboseinc/rnp.git"
  
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "cmocka"
  depends_on "json-c"
  depends_on "botan"

  devel do
    version '0.8.0'
  end

  def install
    jsonc = Formula["json-c"]
    cmocka = Formula["cmocka"]
    
    ENV.append "CFLAGS", "-I#{jsonc.opt_include}/json-c"
    ENV.append "LDFLAGS", "-L#{jsonc.opt_lib} -L#{cmocka.opt_lib}"
    
    (buildpath/"m4").mkpath

    system "autoreconf", "-ivf"
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "rnp", "--version"
  end
end
