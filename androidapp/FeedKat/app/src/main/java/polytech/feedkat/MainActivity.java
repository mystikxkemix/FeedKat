package polytech.feedkat;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Point;
import android.hardware.camera2.params.BlackLevelPattern;
import android.os.Bundle;
import android.support.v7.widget.VectorEnabledTintResources;
import android.view.Display;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.android.volley.Response;
import com.android.volley.VolleyError;

import org.json.JSONObject;

public class MainActivity extends Activity {
    private View mContentView;

    private void initStatic()
    {
        Display display = getWindowManager().getDefaultDisplay();
        Point point = new Point();
        display.getRealSize(point);
        Static.screen_x = point.x;
        Static.screen_y = point.y;
        Static.ecart_bordure = (int)(Static.screen_y*0.0125);
        Static.ecart_tuile = (int)(Static.screen_y*0.035);
        Static.tuile_x=Static.screen_x-2*Static.ecart_bordure;
        Static.tuile_y=(int)(Static.screen_y*0.15);
    }

    @Override

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        initStatic();
        FeedKatAPI.getInstance(getApplicationContext());

        FrameLayout main = (FrameLayout)findViewById(R.id.main_content);

        EditText account = (EditText)findViewById(R.id.Account);
        account.setHintTextColor(Color.parseColor("#88333333"));

        EditText pwd = (EditText)findViewById(R.id.Password);
        pwd.setHintTextColor(Color.parseColor("#88333333"));

        final TextView t = new TextView(this);
        t.setText("FeedKat, pour une alimentation au poil");
        t.setTextSize(20);
        t.setTextColor(Color.BLACK);
        t.setGravity(View.TEXT_ALIGNMENT_CENTER);

        FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp.gravity = Gravity.CENTER_HORIZONTAL | Gravity.TOP;
        lp.setMargins(0,50,0,0);

        t.setLayoutParams(lp);

        main.addView(t);

        final Button button = (Button) findViewById(R.id.Valide_co);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
            EditText compte = (EditText)findViewById(R.id.Account);
            EditText pass   = (EditText)findViewById(R.id.Password);

            FeedKatAPI.getInstance(null).login(compte.getText().toString(), pass.getText().toString(), new Response.Listener<JSONObject>() {
                @Override
                public void onResponse(JSONObject response) {
                    Intent intent = new Intent(MainActivity.this,NavigationActivity.class);
                    startActivity(intent);
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    t.setText("Combinaison mail / password erronée");
                }
            });

            }
        });

    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);

    }

}
