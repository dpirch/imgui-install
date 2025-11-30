include config.mk

OBJDIR = obj
LIB = lib$(LIBNAME).a

MAIN_SRCS = $(wildcard $(IMGUIDIR)/*.cpp)
MAIN_HDRS = $(wildcard $(IMGUIDIR)/*.h)
BACKEND_SRCS = $(BACKENDS:%=$(IMGUIDIR)/backends/imgui_impl_%.cpp)
BACKEND_HDRS = $(BACKENDS:%=$(IMGUIDIR)/backends/imgui_impl_%.h)
SRCS = $(MAIN_SRCS) $(BACKEND_SRCS)
HDRS = $(MAIN_HDRS) $(BACKEND_HDRS)

OBJS = $(SRCS:$(IMGUIDIR)/%.cpp=$(OBJDIR)/%.o)
DEPS = $(OBJS:.o=.d)

# build static library
all: $(LIB)
$(LIB): $(OBJS)
	$(AR) rcs $@ $(OBJS)

$(OBJDIR)/%.o: $(IMGUIDIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) -I$(IMGUIDIR) $(CXXFLAGS) $(EXTRA_CFLAGS) -MD -MP -c $< -o $@

# install
install: $(LIB) $(HDRS) $(PCFILE)
	install -d $(LIBDIR)
	install -m 644 $(LIB) $(LIBDIR)
	install -d $(INCDIR)
	install -m 644 $(HDRS) $(INCDIR)
	install -d $(PKGCONFIGDIR)
	install -m 644 $(PCFILE) $(PKGCONFIGDIR)

uninstall:
	rm -f $(LIBDIR)/$(LIB)
	rm -f $(addprefix $(INCDIR)/,$(notdir $(HDRS)))
	rm -f $(PKGCONFIGDIR)/$(PCFILE)
	-rmdir $(LIBDIR) 2>/dev/null || true
	-rmdir $(INCDIR) 2>/dev/null || true
	-rmdir $(PKGCONFIGDIR) 2>/dev/null || true

#clean
clean:
	rm -rf $(OBJDIR) $(LIB)

-include $(DEPS)

.PHONY: all clean install uninstall
.SUFFIXES:
