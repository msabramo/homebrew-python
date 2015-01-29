class Apsw < Formula
  homepage "http://rogerbinns.github.io/apsw/"
  url "https://github.com/rogerbinns/apsw/releases/download/3.8.8.1-r1/apsw-3.8.8.1-r1.zip"
  sha1 "5a391377fef02131641004f38c2d365383af0c01"
  version "3.8.8.1.1"
  head "https://github.com/rogerbinns/apsw.git"

  option "with-check", "Run build-time tests"
  depends_on :python => :recommended
  depends_on :python3 => :optional
  depends_on "sqlite"

  def install
    Language::Python.each_python(build) do |python, version|
      system python, *Language::Python.setup_install_args(prefix)
      ENV["PYTHONPATH"] = lib/"python#{version}/site-packages"
      system python, "setup.py", "test" if build.with?("check")
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import apsw; print('APSW %s installed at %s' % (apsw.apswversion(), apsw.__file__))"
    end
  end
end
