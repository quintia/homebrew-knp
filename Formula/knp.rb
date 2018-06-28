require "formula"

class Knp < Formula
  homepage "http://nlp.ist.i.kyoto-u.ac.jp/index.php?KNP"
  url "http://nlp.ist.i.kyoto-u.ac.jp/DLcounter/lime.cgi?down=http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-4.19.tar.bz2&name=knp-4.19.tar.bz2"
  sha256 "fe5d1249e7c7716e4ac76a57052096bb8b321829af39f3fa2ad5acd9e060427b"

  depends_on "autoconf"
  depends_on "automake"
  depends_on "libtool"
  
  depends_on "juman"
  depends_on "tinycdb"
  depends_on "crf++"
  
  def patches
    [
      "https://raw.githubusercontent.com/tskoba/homebrew-knp/master/Formula/remove-CRF%2B%2B.patch",
      "https://raw.githubusercontent.com/tskoba/homebrew-knp/master/Formula/remove-cdb.patch"
    ]
  end
  
  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-juman-prefix=#{HOMEBREW_PREFIX}/opt/juman
      --with-crf
    ]

    system "rm -rf CRF++-0.58 cdb"
    system "rm configure Makefile.in crf/Makefile.in ltmain.sh"
    system "glibtoolize"
    system "aclocal"
    system "automake -a"
    system "autoconf"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "false"
  end
end
