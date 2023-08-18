# Generated with JReleaser 1.7.0 at 2023-08-18T12:59:15.348Z
class Couchmove < Formula
  desc "Couchmove is a database migration tool for Couchbase"
  homepage "https://github.com/tchlyah/couchmove"
  version "3.4"
  license "APACHE-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-linux-aarch_64.zip"
    sha256 "8e332061b7392e20e2932c3d13b44871db2d4544fd06b0c3d97281f09a5351be"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-linux-x86_64.zip"
    sha256 "2decb3e4bb9b1dfebb7159d6299105507810e7ef365b1068e8d8b692af4791bf"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-osx.zip"
    sha256 "280e57d9b134b924e10f619e30da6553f92d007ce88351ea3593de96bc9b37e7"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/tchlyah/couchmove/releases/download/v3.4/couchmove-3.4-osx-aarch_64.zip"
    sha256 "625ecc951f50352945a8d75e09013bca68801778cdefd233993ca18439eaa510"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/couchmove" => "couchmove"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/couchmove --version")
    assert_match "3.4", output
  end
end
