/* IS4. Content of a message
\set messageId 824633720985
 */
LOAD 'cameleon_graph';
SET SEARCH_PATH=cameleon_graph, "$user", public;

SELECT * FROM cypher('test', $$
match (m: messagev {id: :messageId})
return 
    m.creationdate,
    coalesce(m.content, m.imagefile)
$$) as (messageCreationDate agtype, messageContent agtype);