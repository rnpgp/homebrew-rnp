class Rnp < Formula
  desc %w[A set of OpenPGP tools for encrypting, decrypting, signing,
          and verifying files, with an emphasis on security and high
          performance.].join(' ')
  homepage 'https://github.com/riboseinc/rnp'
  head 'https://github.com/riboseinc/rnp.git'
  url 'https://github.com/riboseinc/rnp/archive/v0.12.0.tar.gz'
  sha256 '148d8437f15159ee754e77be6b717db2baeaab4e6f5213b9f63fec52ed0b0a39'

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
