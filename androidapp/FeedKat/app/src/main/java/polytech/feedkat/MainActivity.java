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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends Activity {

    private Popup fail_co;
    FrameLayout main;
    public UserData user = new UserData();
    int id;

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

        main = (FrameLayout)findViewById(R.id.main_content);
        final EditText compte = (EditText)findViewById(R.id.Account);
        final EditText pass   = (EditText)findViewById(R.id.Password);
        final Button register = (Button)findViewById(R.id.register);
        final Button button = (Button) findViewById(R.id.Valide_co);

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

        button.setWidth(Static.screen_x/2);
        register.setWidth(Static.screen_x/2);


        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

            button.setClickable(false);
            FeedKatAPI.getInstance(null).login(compte.getText().toString(), pass.getText().toString(), new Response.Listener<JSONObject>() {
                @Override
                public void onResponse(JSONObject response) {
                    try {
                        System.out.println(response);
                        int id = response.getInt("id_user");
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    try
                    {
                        id = response.getInt("id_user");
                    }
                    catch (JSONException e)
                    {
                        e.printStackTrace();
                    }
                    user.setId_user(id);

                    FeedKatAPI.getInstance(null).getCatbyUserId(id, new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                JSONArray cats = response.getJSONArray("cats");
                                for (int i = 0; i < cats.length(); i++) {
                                    JSONObject cat = cats.getJSONObject(i);
                                    new ListeChat(cat.getInt("id_cat"), cat.getString("name"), cat.getInt("ok"), cat.getString("status"), cat.getString("photo"), cat.getString("birth"), cat.getInt("id_dispenser"), cat.getInt("weight"), cat.getJSONArray("feed_times"));
                                }
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }

                        }
                    }, new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {

                        }
                    });
                    FeedKatAPI.getInstance(null).getDispenserbyUserId(id, new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                System.out.println(response);
                                JSONArray disp = response.getJSONArray("dispensers");
                                for (int i = 0; i < disp.length(); i++) {
                                    JSONObject dispenser = disp.getJSONObject(i);
                                    new Dispenser(dispenser.getInt("id_dispenser"), dispenser.getString("name"), dispenser.getInt("stock"));
                                }
                                startActivity(new Intent(MainActivity.this,NavigationActivity.class));
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                        }
                    }, new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {

                        }
                    });


                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    fail_co = new Popup(getApplicationContext(), "Combinaion mail / mot de passe incorrecte", new Response.Listener() {
                        @Override
                        public void onResponse(Object response) {
                            main.removeView(fail_co);
                        }

                    });
                    main.addView(fail_co);
                }
            });

            }
        });

        register.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this,Register.class);
                startActivity(intent);
            }
        });

    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);

    }

}
