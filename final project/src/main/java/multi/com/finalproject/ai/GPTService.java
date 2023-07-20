package multi.com.finalproject.ai;

import java.io.IOException;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service
public class GPTService {
    @Value("${API_KEY}")
    private String API_KEY;
    private static final String OPENAI_API_URL = "https://api.openai.com/v1/engines/davinci-codex/completions";

    private static final OkHttpClient httpClient = new OkHttpClient();

    public static String generateResponse(String prompt, double temperature, int maxTokens) throws IOException {

        MediaType JSON = MediaType.parse("application/json; charset=utf-8");
        String data = String.format("{\"prompt\":\"%s\",\"temperature\":%f,\"max_tokens\":%d}", prompt, temperature, maxTokens);
        RequestBody requestBody = RequestBody.create(JSON, data);

        Request request = new Request.Builder()
                .url(OPENAI_API_URL)
                .addHeader("Content-Type", "application/json")
                .addHeader("Authorization", "Bearer " + GPTConfig.API_KEY)
                .post(requestBody)
                .build();

        try (Response response = httpClient.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Request failed: " + response);

            String responseBody = response.body().string();
            JSONObject jsonObject = new JSONObject(responseBody);

            if (jsonObject.has("choices")) {
                JSONArray choices = jsonObject.getJSONArray("choices");
                if (choices.length() > 0) {
                    String text = choices.getJSONObject(0).getString("text");
                    return text.trim();
                }
            }
        }

        return "";
    }
}
