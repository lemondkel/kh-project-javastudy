import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class Main {
    private static final BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
    static boolean[][] dp;
    public static void main(String[] args) throws IOException {
        int n = Integer.parseInt(br.readLine());
        int []arr = new int[n + 1];
        dp = new boolean[n + 1][n + 1];

        StringTokenizer st = new StringTokenizer(br.readLine());
        for(int i = 1 ; i <= n; i++) {
        	arr[i] = Integer.parseInt(st.nextToken());
        }
        //dp알고리즘 (Dynamic prigramming)
        solve(arr, n);
        int m = Integer.parseInt(br.readLine());
        // 스레드에 안전한지 여부가 전혀 관계없는 프로그램을 개발할 떄 사용
        StringBuilder sb = new StringBuilder();

        for(int i = 0 ; i < m; i++){
            st = new StringTokenizer(br.readLine());
            int start = Integer.parseInt(st.nextToken());
            int end = Integer.parseInt(st.nextToken());

            if(dp[start][end]) sb.append("1\n");
            else sb.append("0\n");
        }

        System.out.println(sb);
    }
    public static void solve(int[] arr, int n){
    	//길이가 1
        for(int i = 1; i <= n; i++)
            dp[i][i] = true;
        //길이가 2
        for(int i = 1; i <= n - 1; i++)
            if(arr[i] == arr[i + 1]) dp[i][i + 1]= true;
        //길이가 3
        for(int i = 2; i < n; i++){
            for(int j = 1; j <= n - i; j++){
                if(arr[j] == arr[j + i] && dp[j + 1][j + i - 1])
                    dp[j][j + i] = true;
            }
        }
    }
}
 

 


