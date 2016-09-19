package polytech.feedkat;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity {
    private View mContentView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);


    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);

    }

}
