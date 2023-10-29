import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class MainActivity extends AppCompatActivity {

    private EditText educationalStatusEditText;
    private EditText interestedFieldsEditText;
    private Button recommendButton;
    private TextView resultTextView;

    private static final String API_KEY = "YOUR_API_KEY";
    private static final String SEARCH_ENGINE_ID = "YOUR_SEARCH_ENGINE_ID";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        educationalStatusEditText = findViewById(R.id.educational_status_edit_text);
        interestedFieldsEditText = findViewById(R.id.interested_fields_edit_text);
        recommendButton = findViewById(R.id.recommend_button);
        resultTextView = findViewById(R.id.result_text_view);

        recommendButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String educationalStatus = educationalStatusEditText.getText().toString();
                String interestedFields = interestedFieldsEditText.getText().toString();

                FetchExamsTask fetchExamsTask = new FetchExamsTask();
                fetchExamsTask.execute(educationalStatus, interestedFields);
            }
        });
    }

    private class FetchExamsTask extends AsyncTask<String, Void, String> {

        @Override
        protected String doInBackground(String... params) {
            String educationalStatus = params[0];
            String interestedFields = params[1];

            String apiUrl = "https://www.googleapis.com/customsearch/v1?key=" + API_KEY +
                    "&cx=" + SEARCH_ENGINE_ID +
                    "&q=" + educationalStatus + " " + interestedFields;

            try {
                URL url = new URL(apiUrl);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");

                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder response = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }

                reader.close
