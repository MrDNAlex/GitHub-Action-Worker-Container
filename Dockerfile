FROM ubuntu:20.04

ENV WORKERVERSION="2.321.0"
ENV DEBIAN_FRONTEND=noninteractive

# Add a new GitWorker User
RUN useradd -ms /bin/bash GitWorker

# Install dependencies and Auto Configure Timezone
RUN apt-get update && apt-get install -y curl tar bash tzdata && \
ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata

# Go into the Directory
WORKDIR /home/GitWorker/ActionRunner

# Download and Extract the GitHub Action Runner
RUN curl -o GitHubActionWorker-x64-${WORKERVERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${WORKERVERSION}/actions-runner-linux-x64-${WORKERVERSION}.tar.gz && \
tar -xzf ./GitHubActionWorker-x64-${WORKERVERSION}.tar.gz && \
rm -rf GitHubActionWorker-x64-${WORKERVERSION}.tar.gz

# Install the Dependencies
RUN cd bin && chmod +x installdependencies.sh && ./installdependencies.sh

# Set the Permissions
RUN chmod -R 775 /home/GitWorker/ActionRunner && \
    chown -R root:root /home/GitWorker/ActionRunner && \
    mkdir -p /home/GitWorker/ActionRunner/_diag && \
    chown -R GitWorker:GitWorker /home/GitWorker/ActionRunner && \
    chmod -R 775 /home/GitWorker/ActionRunner && \
    touch /home/GitWorker/ActionRunner/.env && chmod 664 /home/GitWorker/ActionRunner/.env

# Copy RunWorker.sh
COPY . .

# Change the to the GitWorker User
USER GitWorker

# Run the Worker
CMD ["./RunWorker.sh" ]