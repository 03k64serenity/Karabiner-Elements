all:
	@echo "Read a document at the following URL to build a distributable package."
	@echo "https://github.com/pqrs-org/Karabiner-Elements/#how-to-build"

package: clean
	./make-package.sh

notarize:
	./scripts/notarize-app.sh

staple:
	xcrun stapler staple *.dmg

build:
	$(MAKE) -C src

clean:
	$(MAKE) -C src clean
	rm -rf pkgroot
	rm -f *.dmg

gitclean:
	git clean -f -x -d
	(cd src/vendor/Karabiner-DriverKit-VirtualHIDDevice && git clean -f -x -d)
	(cd src/vendor/Sparkle && git clean -f -x -d)

ibtool-upgrade:
	find * -name '*.xib' | while read f; do xcrun ibtool --upgrade "$$f"; done

swiftformat:
	find src/apps -name '*.swift' -print0 | xargs -0 swiftformat
