package postgresql;

import com.ldbc.impls.workloads.ldbc.snb.interactive.InteractiveTest;
import com.ldbc.impls.workloads.ldbc.snb.postgres.interactive.PostgresInteractiveDb;

import java.util.HashMap;
import java.util.Map;

public class PostgresInteractiveTest extends InteractiveTest {

    public PostgresInteractiveTest() {
        super(new PostgresInteractiveDb());
    }

    String endpoint = "localhost:7484";
    String user = "ldbcuser";
    String databaseName = "ldbcsnb";
    String jdbcDriver = "org.postgresql.ds.PGPoolingDataSource";
    String queryDir = "queries";

    public Map<String, String> getProperties() {
        Map<String, String> properties = new HashMap<>();
        properties.put("endpoint", endpoint);
        properties.put("user", user);
        properties.put("databaseName", databaseName);
        properties.put("jdbcDriver", jdbcDriver);
        properties.put("printQueryNames", "true");
        properties.put("printQueryStrings", "true");
        properties.put("printQueryResults", "true");
        properties.put("queryDir", queryDir);
        return properties;
    }

}
