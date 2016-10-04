package polytech.feedkat;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.TextView;

public class MainActivity extends Activity {
    private View mContentView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);
        FrameLayout main = (FrameLayout)findViewById(R.id.main_content);

        final TextView t = new TextView(this);
        t.setText("FeedKat, pour une alimentation au poil");
        t.setTextSize(20);
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

                if((compte.getText().toString().equals("michael.heidelberger@free.fr"))&&(pass.getText().toString().equals("lolmdr")))
                {
                    System.out.println("connexion success");
                    Intent intent = new Intent(MainActivity.this,NavigationActivity.class);
                    startActivity(intent);
                }
                else
                {
                    System.out.println("connexion fail");
                    t.setText("Combinaison mail / password erronée");
                }
            }
        });

    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);

    }

}
