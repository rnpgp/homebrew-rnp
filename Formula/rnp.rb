class Rnp < Formula
  desc 'OpenPGP (RFC 4880) tools, replacement of GnuPG'
  homepage 'https://github.com/riboseinc/rnp'
  head 'https://github.com/riboseinc/rnp.git'

  depends_on 'cmake' => :build
  depends_on 'json-c'
  depends_on 'botan'

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
