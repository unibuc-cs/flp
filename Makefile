SUBDIRS = C01 C02 C03 C04 C05 C06 C07 C08 C09 C10 C11 C12

.PHONY: all clean clean_extras $(SUBDIRS)

all: $(SUBDIRS)
clean: $(SUBDIRS)
clean-extras: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

