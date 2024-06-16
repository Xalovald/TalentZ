FROM instrumentisto/flutter

RUN sdkmanager --install "platform-tools" "platforms;android-34"

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter clean