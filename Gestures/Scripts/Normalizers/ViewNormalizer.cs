using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Gestures {

    /// <summary>
    /// Normalizer implementation that takes the raw world-space GTransform data and rotates it about the user's position.
    /// </summary>
    /// <remarks> 
    /// The algorithm behind this class is not perfect yet. There are still problems with gestures that are too far above or below the user's eyeline
    /// </remarks>
    public class ViewNormalizer : Normalizer {

        private Transform userTransform;
        private Vector3 forward = new Vector3(0, 0, 1);
        bool first = true;
        Quaternion original;
        Quaternion rotation;
        float t = 0;

        public ViewNormalizer(Transform userTransform) {
            this.userTransform = userTransform;
        }

        public List<GTransform> Normalize(List<GTransform> data) {

            List<GTransform> normalizedData = new List<GTransform>();
            if (first) {
                first = false;
                Vector3 centroid = new Vector3(0, 0, 0);
                int count = data.Count;

                for (int i = 0; i < data.Count; i++) {
                    GTransform trans = data[i].Copy();
                    centroid += trans.position;
                    normalizedData.Add(trans);
                }


                centroid /= count;
                Vector3 userPosition = userTransform.position;
                Vector3 direction = (centroid - userPosition);

                float dp = Vector3.Dot(new Vector3(direction.x, 0, direction.z).normalized, direction.normalized);
                float angle = -Mathf.Sign(direction.y) * Mathf.Acos(dp);
                //Quaternion rotation = Quaternion.AngleAxis(-angle * 360 / (2 * Mathf.PI), new Vector3(direction.z, 0, -direction.x).normalized);
                original = Quaternion.LookRotation(direction.normalized);
                rotation = Quaternion.FromToRotation(direction.normalized, new Vector3(direction.x, 0, direction.z).normalized);
                //rotation = Quaternion.(original, rotation);
                //centroid = rotation * (centroid - userPosition) + userPosition;
                //centroid = normalizedData[0].position;
                //Vector3 direction2 = (centroid - userPosition).normalized;
                //Quaternion rotation2 = Quaternion.FromToRotation(new Vector3(direction2.x, 0, direction2.z), forward);

            } else {

                Vector3 centroid = new Vector3(0, 0, 0);
                int count = data.Count;

                for (int i = 0; i < data.Count; i++) {
                    GTransform trans = data[i].Copy();
                    centroid += trans.position;
                    normalizedData.Add(trans);
                }

                centroid /= count;

                Vector3 direction = (centroid - userTransform.position).normalized;

                for (int i = 0; i < data.Count; i++) {
                    GTransform trans = normalizedData[i];
                    Vector3 p = trans.position;
                    Vector3 r = centroid;
                    Vector3 q = centroid + new Vector3(direction.z, 0, -direction.x).normalized;
                    Vector3 rq = (r - q).normalized;
                    float tt = Vector3.Dot(rq, (q - p)) / Vector3.Dot(rq, rq);
                    Vector3 newC = new Vector3(p.x, centroid.y, p.z);

                    Quaternion rotation2 = Quaternion.FromToRotation(direction, forward);

                    Vector3 dir = (newC - userTransform.position);
                    Quaternion rot = Quaternion.FromToRotation(dir.normalized, new Vector3(dir.x, 0, dir.z).normalized);

                    Quaternion rr = Quaternion.Lerp(Quaternion.identity, rot, t);
                    trans.position = rr * (trans.position - userTransform.position) + userTransform.position;
                }


                t += 0.01f;

            }

            return normalizedData;
        }


    }
}
