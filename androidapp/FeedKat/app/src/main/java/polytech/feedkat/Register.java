package polytech.feedkat;

import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;
import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.InputType;
import android.text.method.PasswordTransformationMethod;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.android.volley.Response;
import com.android.volley.VolleyError;

import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;

import java.net.PasswordAuthentication;

public class Register extends Activity {

    Popup popup;
    FrameLayout main;
    UserData user;
    int id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        FrameLayout header = (FrameLayout) findViewById(R.id.header);
        main = (FrameLayout)findViewById(R.id.activity_register);

        FrameLayout.LayoutParams lp_header = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, Static.screen_y / 10);
        lp_header.gravity = Gravity.CENTER_HORIZONTAL | Gravity.TOP;
        header.setLayoutParams(lp_header);

        TextView t = new TextView(this);
        t.setText("Inscription");
        FrameLayout.LayoutParams lp_text = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
        lp_text.gravity = Gravity.CENTER;
        t.setGravity(View.TEXT_ALIGNMENT_CENTER);
        t.setTextSize(20);
        t.setLayoutParams(lp_text);
        header.addView(t);

        FrameLayout body = new FrameLayout(this);

        FrameLayout.LayoutParams lp_body = new FrameLayout.LayoutParams(Static.screen_x-2*Static.ecart_bordure, Static.screen_y-Static.screen_y / 10);
        lp_body.setMargins(Static.ecart_bordure,Static.screen_y/10,0,0);
        body.setLayoutParams(lp_body);


        final EditText surname = new EditText(this);
        surname.setHintTextColor(Color.parseColor("#88333333"));
        surname.setHint("Nom");
        surname.setTextColor(Color.BLACK);
        surname.setGravity(View.TEXT_ALIGNMENT_GRAVITY);
        FrameLayout.LayoutParams lp_surname = new FrameLayout.LayoutParams(Static.screen_x/2, Static.screen_y/15);
        lp_surname.setMargins(Static.ecart_bordure,Static.ecart_bordure*5,0,0);
        lp_surname.gravity = Gravity.CENTER_HORIZONTAL;
        surname.setLayoutParams(lp_surname);
        body.addView(surname);

        final EditText first_name = new EditText(this);
        first_name.setHintTextColor(Color.parseColor("#88333333"));
        first_name.setHint("Prénom");
        first_name.setTextColor(Color.BLACK);
        first_name.setGravity(View.TEXT_ALIGNMENT_GRAVITY);
        FrameLayout.LayoutParams lp_firstname = new FrameLayout.LayoutParams(Static.screen_x/2, Static.screen_y/15);
        lp_firstname.setMargins(Static.ecart_bordure,Static.ecart_bordure*6 +Static.screen_y/15,0,0);
        lp_firstname.gravity = Gravity.CENTER_HORIZONTAL;
        first_name.setLayoutParams(lp_firstname);
        body.addView(first_name);

        final EditText mail = new EditText(this);
        mail.setHintTextColor(Color.parseColor("#88333333"));
        mail.setHint("Mail");
        mail.setTextColor(Color.BLACK);
        mail.setInputType(InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS);
        mail.setGravity(View.TEXT_ALIGNMENT_GRAVITY);
        FrameLayout.LayoutParams lp_mail = new FrameLayout.LayoutParams(Static.screen_x/2, Static.screen_y/15);
        lp_mail.setMargins(Static.ecart_bordure,Static.ecart_bordure*7 +2*Static.screen_y/15,0,0);
        lp_mail.gravity = Gravity.CENTER_HORIZONTAL;
        mail.setLayoutParams(lp_mail);
        body.addView(mail);

        final EditText pass = new EditText(this);
        pass.setHintTextColor(Color.parseColor("#88333333"));
        pass.setHint("Mot de passe");
        pass.setTextColor(Color.BLACK);
        pass.setInputType(InputType.TYPE_TEXT_VARIATION_PASSWORD);
        pass.setTransformationMethod(PasswordTransformationMethod.getInstance());
        pass.setGravity(View.TEXT_ALIGNMENT_GRAVITY);
        FrameLayout.LayoutParams lp_pass = new FrameLayout.LayoutParams(Static.screen_x/2, Static.screen_y/15);
        lp_pass.setMargins(Static.ecart_bordure,Static.ecart_bordure*8 +3*Static.screen_y/15,0,0);
        lp_pass.gravity = Gravity.CENTER_HORIZONTAL;
        pass.setLayoutParams(lp_pass);
        body.addView(pass);

        final EditText pass_confirm = new EditText(this);
        pass_confirm.setHintTextColor(Color.parseColor("#88333333"));
        pass_confirm.setHint("Confirmation");
        pass_confirm.setTextColor(Color.BLACK);
        pass_confirm.setInputType(InputType.TYPE_TEXT_VARIATION_PASSWORD);
        pass_confirm.setTransformationMethod(PasswordTransformationMethod.getInstance());
        pass_confirm.setGravity(View.TEXT_ALIGNMENT_GRAVITY);
        FrameLayout.LayoutParams lp_pass_confirm = new FrameLayout.LayoutParams(Static.screen_x/2, Static.screen_y/15);
        lp_pass_confirm.setMargins(Static.ecart_bordure,Static.ecart_bordure*9 +4*Static.screen_y/15,0,0);
        lp_pass_confirm.gravity = Gravity.CENTER_HORIZONTAL;
        pass_confirm.setLayoutParams(lp_pass_confirm);
        body.addView(pass_confirm);

        Button confirm = new Button(this);
        confirm.setText("S'inscrire");
        confirm.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
        FrameLayout.LayoutParams lp_confirm = new FrameLayout.LayoutParams(Static.screen_x/2,Static.screen_y/15);
        lp_confirm.gravity = Gravity.CENTER_HORIZONTAL;
        lp_confirm.setMargins(Static.ecart_bordure,Static.ecart_bordure*10+5*Static.screen_y/15,0,0);
        confirm.setLayoutParams(lp_confirm);
        body.addView(confirm);



        main.addView(body);


        confirm.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                if(pass.getText().toString().equals(pass_confirm.getText().toString()))
                {
                    FeedKatAPI.getInstance(getApplicationContext()).register(mail.getText().toString(), pass.getText().toString(), surname.getText().toString(), first_name.getText().toString(), new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(final JSONObject response) {
                            popup = new Popup(getApplicationContext(), "L'utilisateur a été créé", new Response.Listener() {
                                @Override
                                public void onResponse(Object t) {
                                    main.removeView(popup);
                                    try
                                    {
                                        id = response.getInt("id_user");
                                    }
                                    catch (JSONException e)
                                    {
                                        e.printStackTrace();
                                    }
                                    user.setId_user(id);

                                    Intent intent = new Intent(Register.this, NavigationActivity.class);
                                    startActivity(intent);
                                }
                            });
                            main.addView(popup);
                        }
                    }, new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            popup = new Popup(getApplicationContext(), "Adresse mail déjà utilisée", new Response.Listener() {
                                @Override
                                public void onResponse(Object response) {
                                    main.removeView(popup);
                                }
                            });
                            main.addView(popup);
                        }
                    });
                }
                else
                {
                    popup = new Popup(getApplicationContext(), "Mots de passe non identiques", new Response.Listener() {
                        @Override
                        public void onResponse(Object response) {
                            main.removeView(popup);
                        }
                    });
                    main.addView(popup);
                }
            }
        });
    }



    public void onBackPressed(){
        Intent intent = new Intent (Register.this, MainActivity.class);
        startActivity(intent);
        return;
    }
}
