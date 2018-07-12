class Rnp < Formula
  desc %w[A set of OpenPGP tools for encrypting, decrypting, signing,
          and verifying files, with an emphasis on security and high
          performance.].join(' ')
  homepage 'https://github.com/riboseinc/rnp'
  head 'https://github.com/riboseinc/rnp.git'
  url 'https://github.com/riboseinc/rnp/archive/v0.9.0.tar.gz'
  sha256 'be23463a24c223ce8029d28594ff565386c326ade750fbf49240db87365de720'

  depends_on 'cmake' => :build
  depends_on 'json-c'
  depends_on 'botan'

  needs :cxx11

  def install
    jsonc = Formula['json-c']
    botan = Formula['botan']

    mkdir 'build' do
      system(
        'cmake',
        '-DBUILD_SHARED_LIBS=ON',
        '-DBUILD_TESTING=OFF',
        "-DCMAKE_INSTALL_PREFIX=#{prefix}",
        "-DCMAKE_PREFIX_PATH=#{botan.prefix};#{jsonc.prefix}",
        *std_cmake_args,
        '..'
      )
      system 'make', 'install'
    end
  end

  test do
    system 'rnp', '--version'
  end
end
