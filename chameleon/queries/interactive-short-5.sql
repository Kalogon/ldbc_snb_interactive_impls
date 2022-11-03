/* IS5. Creator of a message
\set messageId 824633720985
 */
LOAD 'cameleon_graph';
SET SEARCH_PATH=cameleon_graph, "$user", public;

SELECT * FROM cypher('test', $$
match (m: messagev {id: :messageId})-[:hascreator]->(p: personv)
return p.id, p.firstname, p.lastname
$$) as (personId agtype, firstName agtype, lastName agtype);