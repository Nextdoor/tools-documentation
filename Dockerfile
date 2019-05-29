FROM nextdoor/tools-base:v1.0.1

# Install go, sphinx and the sphinx extensions available via apt
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    golang-1.10=1.10.4-2ubuntu1~18.04.1 \
    python3-pip=9.0.1-2.3~ubuntu1 \
    python3-sphinx=1.6.7-1ubuntu1 \
    python3-sphinx-argparse=0.1.15-3 \
    python3-sphinxcontrib.bibtex=0.3.6-2 \
    python3-sphinxcontrib.httpdomain=1.5.0-2 \
    python3-sphinxcontrib.nwdiag=0.9.5-1 \
    python3-sphinxcontrib.plantuml=0.5-4

# Install godocjson to generate Go documentation
RUN ln -sf /usr/lib/go-1.10/bin/go /usr/bin/go
RUN go get github.com/rtfd/godocjson

# Install jsdoc to generate Javascript documentation
RUN wget https://deb.nodesource.com/setup_10.x -O nodesource_setup.sh && bash nodesource_setup.sh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
RUN npm install jsdoc -g

# Install Sphinx AutoAPI and golangdomain
RUN pip3 install sphinx-autoapi==1.0.0 \
    sphinxcontrib-golangdomain==0.2.0.dev0

# Link Sphinx tools into /tool directory to allow discovery
RUN ln -sf /usr/bin/sphinx-apidoc /tool/bin/sphinx-apidoc && \
    ln -sf /usr/bin/sphinx-autogen /tool/bin/sphinx-autogen && \
    ln -sf /usr/bin/sphinx-build /tool/bin/sphinx-build && \
    ln -sf /usr/bin/sphinx-quickstart /tool/bin/sphinx-quickstart && \
    chown tool:tool /tool/bin/*
