class Rnp < Formula
  desc %w[A set of OpenPGP tools for encrypting, decrypting, signing,
          and verifying files, with an emphasis on security and high
          performance.].join(' ')
  homepage 'https://github.com/riboseinc/rnp'
  head 'https://github.com/riboseinc/rnp.git'
  url 'https://github.com/riboseinc/rnp/archive/v0.10.0.tar.gz'
  sha256 'bf5c29b6ce9c05913c742c2bd9914fb78ca3316a8a279bdababb5b58f083de0a'

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
