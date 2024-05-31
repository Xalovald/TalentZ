FROM instrumentisto/flutter

RUN sdkmanager --install "platform-tools" "platforms;android-34"

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter clean
RUN flutter build apk --debug --split-per-abi