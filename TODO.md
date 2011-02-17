General
-------

* Research which OSS license the app should have and that we adhere to the licenses of APIs.
  TVDB: http://forums.thetvdb.com/viewtopic.php?f=8&t=2507
* Add a Show property to a Episode, which holds the show related data that we now store on the episode itself.
* Resize the show posters on the API side to increase download speeds, when we know exactly which sizes we need.
* Set the preferred show poster thumb size from the calendar controller.
* Handle connection errors in some way which is needed to provide a good UX. I.e. should we retry, take a failure block, etc.

Authentication
--------------

* Settings screen to enter username
* Way to check if username exists
* Add user credentials as basic-auth headers to _all_ requests to itrakt.matsimitsu.com.
  Ideally to trakt.tv as well, but this has to be discussed with them first, so for now wait with calls like 'seen' POSTs.

Caching
-------

* Cache show posters and thumbs indefinitely.

API
---

* The API should return whether or not the user has seen the episode in the show json
* A calendar feed for users that aren't signed in or aren't registered trakt.tv users
* Search through all shows

Design discussion
-----------------

* All lists should be searchable (filter)
* All top-level views should have a reload button

* First launch: load calendar, then visible row images + library & trending feeds
* Not first launch, i.e. the app was inactive, or the user hits the 'reload' button: reload _all_ feeds, but load the current visible one first.

* Calendar text:
  <pre><code>
    7x22: Show title
    Episode title
    9 PM on ABC
  </code></pre>

* Use default trakt image for when images aren't loaded yet (pass default image to Thijs for editing)

* Shows that the user has in her library should *not* show up in 'trending'

* The trending view should have images *and* have the following text, where the first part is an excerpt of the description like Mail does for emails:
  <pre><code>
    How I Met Your Mother is a comedy about Ted and how he fell…
    Genre Comedy
    <3 96%
  </code></pre>

* The library view should not have images. This is the user's library, so she'll recognize shows by name. This also makes it easy to differentiate between library/trending.

* The show details view should have a disclosure entry top go to the seasons/episodes list view and says how many episodes there are in total: `Episodes (23) >`
  Let's leave the episode count be for now, not sure if that's really useful.
* The seasons/episodes table view should have season groups like the calendar view, with episode entries like: `[√] Episode title >`
  The checkbox should be like the one in Things.

* The eipsode details view should have a disclosure entry to the show's episodes list
* The 'seen' entry in the episode details view should have the same checkbox as in the episodes list. (The one from Things)

* Shows and show episodes list views should show a quick alphabetic navigation thingie when it makes sense. See the HIG.
