/* IS3. Friends of a Person
\set personId 17592186044461
 */
LOAD 'cameleon_graph';
SET SEARCH_PATH=cameleon_graph, "$user", public;

SELECT * FROM cypher('test', $$
match (n:personv { id: :personId })-[r:knows]-(friend)
return
    friend.id as personId,
    friend.firstname as firstName,
    friend.lastname as lastName,
    r.creationdate as friendshipCreationDate
order by
    r.creationdate desc,
    toInteger(friend.id) asc
$$) as (personId agtype, firstName agtype, lastName agtype, friendshipCreationDate agtype);