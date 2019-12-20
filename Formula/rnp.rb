class Rnp < Formula
  desc %w[A set of OpenPGP tools for encrypting, decrypting, signing,
          and verifying files, with an emphasis on security and high
          performance.].join(' ')
  homepage 'https://github.com/rnpgp/rnp'
  head 'https://github.com/rnpgp/rnp.git'
  url 'https://github.com/rnpgp/rnp.git',
       :tag      => 'v0.12.0',
       :revision => '586caec6cd728d54dbd281cafe17ee2e1f29dbf1'

  depends_on 'cmake' => :build
  depends_on 'json-c'
  depends_on 'botan'

  def install
    jsonc = Formula['json-c']
    botan = Formula['botan']

    tag = `git describe`
    ohai "Building tag #{tag}"
    # only required to set when can't be determined automatically
    # version tag

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
